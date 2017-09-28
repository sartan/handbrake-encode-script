#!/usr/bin/env bash

function usage {
    echo -e "\nusage: $0 [src_dir] [dest_dir]\n"
    exit 1
}

if [[ $# != 2 ||  $@ == "--help" ]]
then
  usage
  exit 0
fi

src_dir=$1
output_dir=$2
log_file="${src_dir}/.last_processed"

mkdir -p "${output_dir}"
touch "${log_file}"

last_processed=`cat "${log_file}"`

args=("${src_dir}" -name *.mp4)

if [ -n "${last_processed}" ]; then
  args+=(-newer "${last_processed}")
fi

find "${args[@]}" | tr '\n' '\0' | xargs -0 ls -rt | (
  while read src_file; do
      last_processed=${src_file}
      file_name=`basename "${src_file}"`
      dest_file="${output_dir}/${file_name}"
      HandBrakeCLI --input "${src_file}" --output "${dest_file}" --encoder x264 --quality 20 --rate 30 --ab 64 --maxWidth 720 --optimize < /dev/null
  done
  echo "${last_processed}" > "${log_file}" 2>&1
)

