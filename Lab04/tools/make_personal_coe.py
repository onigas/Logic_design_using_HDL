#!/usr/bin/env python3
from __future__ import annotations
import argparse, datetime as dt, re
from pathlib import Path

def main() -> None:
    parser = argparse.ArgumentParser(description="Encode a six-character code, MI, and YYYYMMDD as ROM data")
    parser.add_argument("student_code")
    parser.add_argument("date")
    args = parser.parse_args()
    if re.fullmatch(r"[A-Za-z0-9]{6}", args.student_code) is None:
        parser.error("student_code must contain exactly six ASCII letters or digits")
    if re.fullmatch(r"[0-9]{8}", args.date) is None:
        parser.error("date must contain exactly eight digits in YYYYMMDD order")
    dt.datetime.strptime(args.date, "%Y%m%d")
    phrase = args.student_code + "MI" + args.date
    octets = list(phrase.encode("ascii"))
    words = [(octets[i] << 8) | octets[i + 1] for i in range(0, 16, 2)]
    out_dir = Path(__file__).resolve().parents[1] / "personal_data"
    out_dir.mkdir(exist_ok=True)
    dist_path = out_dir / "personal_dist_rom16.coe"
    block_path = out_dir / "personal_block_rom8x16.coe"
    dist_path.write_text("; One ASCII character per 8-bit location\nmemory_initialization_radix = 16;\nmemory_initialization_vector =\n" + "\n".join(" ".join(f"{v:02X}" for v in octets[i:i+4]) + (";" if i==12 else "") for i in range(0,16,4)) + "\n", encoding="ascii")
    block_path.write_text("; Two consecutive ASCII characters per 16-bit location\nmemory_initialization_radix = 16;\nmemory_initialization_vector =\n" + ", ".join(f"{v:04X}" for v in words[:4]) + ",\n" + ", ".join(f"{v:04X}" for v in words[4:]) + ";\n", encoding="ascii")
    print(f"Text: {phrase}")
    print(f"Distributed ROM: {dist_path}")
    print(f"Block ROM:       {block_path}")

if __name__ == "__main__":
    main()
