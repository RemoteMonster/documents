#!/usr/bin/env bash

echo "=========================="
echo "YOU NEED TO INSTALL PANDOC"
echo "=========================="

SRC_DIR='./src'
DIST_DIR='./dist'
files=($(find ${SRC_DIR} -type f -name '*.md'))

[ -d "${DIST_DIR}" ] || mkdir ${DIST_DIR}

for file in ${files[*]}
do
  file_name=(${file##*/})
  echo $file $file_name

  # readarray -td/ paths <<< "$file"; declare -p paths; // macos does not work
  IFS='/' read -r -a paths <<< "$file";
  paths_depth=${#paths[@]}
  echo ${paths[*]} $paths_depth
  
  if [ ${paths_depth} -gt "3" ]
  then
    sub_dir=${paths[2]}
    echo $sub_dir
    
    [ -d "$DIST_DIR/$sub_dir" ] || mkdir ${DIST_DIR}/${sub_dir}
    out_dir=(${DIST_DIR}/${sub_dir})
    echo $out_dir
  else
    out_dir=(${DIST_DIR})
    echo $out_dir
  fi

  pandoc $file -f markdown -t docx -o ${out_dir}/${file_name}.docx
done

