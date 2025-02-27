#!/bin/bash

: "${FCC_LICENSE_URL:=https://data.fcc.gov/download/pub/uls/complete/l_amat.zip}"
: "${FCC_LICENSE_DIR:=./db}"

set -e

tmpdir=$(mktemp -d fccdbXXXXXX)
trap 'rm -rf $tmpdir' EXIT

echo "Downloading $FCC_LICENSE_URL"
zipfile="$tmpdir/l_amat.zip"
curl -LfsS -o "$zipfile" "$FCC_LICENSE_URL"

duckdb "$tmpdir/fcc.db" < schema.sql

import() {
  local filename
  local tablename
  filename=$1
  tablename=$2
  echo "Importing $filename..."
  unzip -p "$zipfile" "$filename" | duckdb "$tmpdir/fcc.db" "COPY $tablename FROM '/dev/stdin' (DELIMITER '|', quote '', ignore_errors true)"
}

import EN.dat entity
import AM.dat amateur
import HS.dat history

mv "$tmpdir/fcc.db" fcc.db
