#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jan 22 13:03:58 2026

@author: gllore
"""

import re
import numpy as np
from pathlib import Path


class MyRead:
    """
    Reader for Geopsy dispersion text files containing
    Rayleigh and Love modes separated by comment headers.
    """

    MODE_RE = re.compile(r"^\s*#\s*Mode\s+(\d+)", re.IGNORECASE)
    RAYLEIGH_RE = re.compile(r"Rayleigh", re.IGNORECASE)
    LOVE_RE = re.compile(r"Love", re.IGNORECASE)

    def __init__(self, path):
        self.path = Path(path)

    def geopsy_dispersion(self):
        """
        Read the dispersion file and return modes as:

        {
            "Rayleigh": {mode: (x_array, y_array), ...},
            "Love":     {mode: (x_array, y_array), ...}
        }
        """
        modes = {
            "Rayleigh": {},
            "Love": {}
        }

        current_wave = None
        current_mode = None
        buffer = []

        def flush():
            nonlocal buffer, current_wave, current_mode
            if buffer and current_wave is not None and current_mode is not None:
                arr = np.array(buffer, dtype=float)
                modes[current_wave][current_mode] = (arr[:, 0], arr[:, 1])
            buffer = []

        with self.path.open("r") as f:
            for line in f:
                s = line.strip()
                if not s:
                    continue

                # --- comment / header lines ---
                if s.startswith("#"):
                    if self.RAYLEIGH_RE.search(s):
                        flush()
                        current_wave = "Rayleigh"
                        current_mode = None
                        continue

                    if self.LOVE_RE.search(s):
                        flush()
                        current_wave = "Love"
                        current_mode = None
                        continue

                    m = self.MODE_RE.match(s)
                    if m:
                        flush()
                        current_mode = int(m.group(1))
                        modes[current_wave].setdefault(current_mode, ())
                        continue

                    continue  # ignore other comments

                # --- numeric data lines ---
                if current_wave is None or current_mode is None:
                    continue

                parts = s.split()
                if len(parts) < 2:
                    continue

                try:
                    x = float(parts[0])
                    y = float(parts[1])
                except ValueError:
                    continue

                buffer.append((x, y))

        flush()
        return modes
