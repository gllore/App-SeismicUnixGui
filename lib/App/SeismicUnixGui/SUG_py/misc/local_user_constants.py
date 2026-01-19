#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Jan 17 17:57:57 2026

@author: gllore
"""

import os
from pathlib import Path
    
class myProject_config:
     
     def __init__(self):
         # compute once at construction
         # and store values
         self._collect()
         self._definition()  # needs to be called only once
         self._as_dict()
         self.project_config = read_myProject_config(self.ACTIVE_PROJECT_name)


     def _collect(self):
        """Collect environment variables
        Potentially useful later
        Path is needed at least once, to allow / later on
        but only for paths """
        self.home         = Path(os.environ.get("HOME"))
        self.user         = os.environ.get("USER")
        self.pythonpath   = os.environ.get("PYTHONPATH", "")
        self.conda_prefix = os.environ.get("CONDA_PREFIX")
        self.SeismicUnixGui = os.environ.get("SeismicUnixGui")
        
     def _definition(self):
        """ local user definitions"""
        self.ACTIVE_PROJECT = self.home / ".L_SU" / "configuration" / "active"
        
        self.ACTIVE_PROJECT_name = self.ACTIVE_PROJECT / "Project.config"
        
     def _as_dict(self):
        """Optional: export as dict"""
        """Converts the object into a serializable representation"""
        return {
            "home": self.home,
            "user": self.user,
            "pythonpath": self.pythonpath,
            "conda_prefix": self.conda_prefix,
            "SeismicUnixGui": self.SeismicUnixGui,
            "ACTIVE_PROJECT_name": self.ACTIVE_PROJECT_name, 
        }

# Define a function that reads a project configuration file
# This reads Project.config and stores the parsed results in 'config'
# - path: a pathlib.Path pointing to Project.config
# - -> dict: the function returns a Python dictionary
def read_myProject_config(path: Path) -> dict:

    # Create an empty dictionary to store key-value pairs
    # Each config entry will become: config[key] = parsed_value
    config = {}

    # Open the file safely using a context manager
    # This ensures the file is automatically closed when done
    with path.open() as f:

        # Iterate over the file line by line
        for line in f:

            # Remove leading/trailing whitespace and newline characters
            # Example: " key = value \n" → "key = value"
            line = line.strip()

            # Skip empty lines or comment lines
            # - not line        → blank line
            # - startswith("#") → comment
            if not line or line.startswith("#"):
                continue  # move to the next line

            # If the line does not contain '=', it is not a valid key=value pair
            # Skip it safely
            if "=" not in line:
                continue

            # Split the line into key and value at the FIRST '=' only
            # Example: "A = B = C" → key="A", value="B = C"
            # str.strip removes extra whitespace from both key and value
            key, value = map(str.strip, line.split("=", 1))

            # Handle empty values explicitly
            # Example: "spare_dir ="
            # Store None to indicate "defined but empty"
            if value == "":
                config[key] = None
                continue

            # Remove surrounding single quotes from strings
            # Example: "'loma_blanca'" → "loma_blanca"
            if value.startswith("'") and value.endswith("'"):
                value = value[1:-1]

            # Convert yes/no strings into Python booleans
            # - "yes" → True
            # - "no"  → False
            if value.lower() in ("yes", "no"):
                config[key] = value.lower() == "yes"
                continue

            # Heuristic: if the value starts with '/', treat it as a filesystem path
            # Convert it to a pathlib.Path for safe path operations
            if value.startswith("/"):
                config[key] = Path(value)
                continue

            # Fallback case:
            # If none of the above rules applied, store the value as a string
            config[key] = value

    # After processing all lines, return the populated dictionary
    return config



