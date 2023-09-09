
base_dir=/app/cow
lower_dir="${base_dir}/lower"
upper_dir="${base_dir}/upper"
work_dir="${base_dir}/work"
merged_dir="${base_dir}/merged"

mount -t tmpfs tmpfs ${base_dir}

mkdir -p "${lower_dir}" "${upper_dir}" "${work_dir}" "${merged_dir}"



echo "Lower file" > "${lower_dir}/file.txt"
echo "Upper file" > "${upper_dir}/file.txt"

mount -t overlay overlay -o lowerdir="${lower_dir}",upperdir="${upper_dir}",workdir="${work_dir}" "${merged_dir}"
