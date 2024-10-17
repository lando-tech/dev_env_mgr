import sys
import subprocess
import os
import platform


def create_python_env(env_name='.venv', requirements_file='requirements.txt'):
    # Create venv
    subprocess.run([sys.executable, "-m", "venv", env_name])

    # Get os type
    os_type = platform.system()

    if os_type == "Windows":
        activate_script = os.path.join(env_name, "Scripts", "activate")
        command = f"call {activate_script} && pip install -r {requirements_file}"
    else:  # POSIX (Linux, Mac, etc.)
        # Activate venv
        activate_script = os.path.join(env_name, "bin", "activate")
        command = f". {activate_script}, && pip install -r {requirements_file}"

    # Install dependencies from requirements_file
    subprocess.run(
        command, shell=True, executable="/bin/bash" if os_type != "Windows" else None
    )

