#!/bin/bash

# ---- Define base directory ---- #
BASE_DIR="./"

# ---- Create directory structure ---- #
mkdir -p "$BASE_DIR"/{envs,resources/Data,resources/Logs,resources/Outputs,resources/Databases/,results,workflow,scripts}

echo "Working environment '$BASE_DIR' created with required subdirectories."

