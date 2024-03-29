#!/bin/bash

echo "This tool is going to setup a venv/global conda environment."
echo "Please make sure you are using Python 3.10 or higher."
echo "Use this script with caution."

# Check Python version
python_version=$(python -c "import sys; print(sys.version_info.major)")
python_minor_version=$(python -c "import sys; print(sys.version_info.minor)")

if [[ $python_version -lt 3 || ($python_version -eq 3 && $python_minor_version -lt 10) ]]; then
    echo "Error: Python 3.10 or higher is required. You are using Python $python_version.$python_minor_version."
    exit 1
fi

# Prompt user for virtual environment choice
read -p "Do you want to use venv or conda? (venv/conda): " env_choice
read -p "what should be the name of your new environment? (venv): " env_name

if [[ $env_choice == "venv" ]]; then
    # Create and activate venv
    python -m venv $env_name
    source $env_name/bin/activate
elif [[ $env_choice == "conda" ]]; then
    # Create and activate conda environment 
    conda create --name $env_name python=3.11 -y
    source activate $env_name
    conda install pip
else
    echo "Invalid choice. Please choose either 'venv' or 'conda' or numbers between 1 and 2"
    exit 1
fi

# Prompt user for backend choice
read -p "Do you want to use PyTorch or TensorFlow? (pytorch/tensorflow): " backend_choice

if [[ $backend_choice == "pytorch" ]]; then
    # Install PyTorch and Keras
    pip install torch torchvision
    pip install keras --upgrade
elif [[ $backend_choice == "tensorflow" ]]; then
    # Install TensorFlow and Keras
    pip install tensorflow
    pip install keras --upgrade
else
    echo "Invalid choice. Please choose either 'pytorch' or 'tensorflow'."
    exit 1  
fi

echo "Setup complete. Keras 3 with $backend_choice backend has been installed in the $env_choice environment."