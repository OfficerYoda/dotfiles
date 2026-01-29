#!/usr/bin/env python3
import os
import subprocess
import sys
import fnmatch
import platform

# Configuration
CONFIG_FILE = os.path.expanduser("~/.config/chezmoi-sync.toml")


def load_toml(path):
    # simple parser to avoid external dependencies like 'tomli'
    config = {
        "root": "",
        "include": {"directories": [], "files": []},
        "ignore": {"patterns": []},
    }
    current_section = None

    with open(path, "r") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue

            if line.startswith("[") and line.endswith("]"):
                current_section = line[1:-1]
                continue

            if "=" in line:
                key, value = [x.strip() for x in line.split("=", 1)]
                value = value.strip(' "[]')

                # Handle root
                if key == "root" and current_section is None:
                    config["root"] = value
                    continue

                # Handle lists (very basic parsing for single lines)
                if current_section == "include":
                    if key == "directories" or key == "files":
                        # This parser assumes one item per line or simple lists.
                        # For robustness, we'll manually gather items below if complex.
                        pass

                # Manual hack for list parsing without external libs
                # (Reading the file directly into lists for simplicity)
                pass

    # Re-reading for robust list handling without pip modules
    import re

    with open(path, "r") as f:
        content = f.read()

    # Extract lists using regex
    def get_list(name):
        match = re.search(rf"{name}\s*=\s*\[(.*?)\]", content, re.DOTALL)
        if match:
            return [
                x.strip().strip("\"'") for x in match.group(1).split(",") if x.strip()
            ]
        return []

    config["root"] = re.search(r'root\s*=\s*"(.*?)"', content).group(1)
    config["include"]["directories"] = get_list("directories")
    config["include"]["files"] = get_list("files")
    config["ignore"]["patterns"] = get_list("patterns")

    return config


def main():
    if not os.path.exists(CONFIG_FILE):
        print(f"Error: Config file not found at {CONFIG_FILE}")
        sys.exit(1)

    cfg = load_toml(CONFIG_FILE)
    root_dir = os.path.expanduser(cfg["root"])
    files_to_add = set()

    print(f"Scanning {root_dir}...")

    # 1. Process Directories
    for d in cfg["include"]["directories"]:
        dir_path = os.path.join(root_dir, d)
        if not os.path.exists(dir_path):
            continue
        for root, _, files in os.walk(dir_path):
            for file in files:
                full_path = os.path.join(root, file)
                files_to_add.add(full_path)

    # 2. Process Individual Files
    for f in cfg["include"]["files"]:
        # Handle paths starting with ../ relative to root
        if f.startswith("../"):
            # Resolve relative to root_dir
            full_path = os.path.abspath(os.path.join(root_dir, f))
        elif f.startswith("~") or f.startswith("/"):
            full_path = os.path.expanduser(f)
        else:
            full_path = os.path.join(root_dir, f)

        if os.path.exists(full_path):
            files_to_add.add(full_path)

    # 3. Filter Ignores
    final_list = []
    ignores = cfg["ignore"]["patterns"]

    for file_path in files_to_add:
        rel_path = os.path.relpath(file_path, root_dir)
        ignored = False

        for pattern in ignores:
            # Check if the relative path matches the pattern
            if fnmatch.fnmatch(rel_path, pattern) or fnmatch.fnmatch(
                rel_path, pattern + "/*"
            ):
                ignored = True
                break

        if not ignored:
            final_list.append(file_path)

    # 4. Run Chezmoi

    if platform.system() == "Darwin":
        chezmoi_location = "/opt/homebrew/bin/chezmoi"
    else:
        chezmoi_location = "/usr/bin/chezmoi"
    if final_list:
        print(f"Adding {len(final_list)} files to chezmoi...")
        if platform.system() == "Darwin":
            cmd = [chezmoi_location, "add"] + final_list
        else:
            cmd = [chezmoi_location, "add"] + final_list
        print(cmd)
        subprocess.run(cmd)
        print("Done.")
    else:
        print("No files found to add.")

    subprocess.run([chezmoi_location, "apply", "--force"])


if __name__ == "__main__":
    main()
