IFS=$'\n'
for file in $(ls /Users/kareem/Documents/test/*docx); do
    dos2unix $file 2>/dev/null
    textutil -convert txt $file

    original=$(echo "${file// /_}" | sed 's/docx/txt/')
    new=$original.new
    tmp=$original.tmp

    cp $original $tmp
    perl -pi -e 's/\\ \n//g' $tmp && perl -pi -e 's/\\\n//g' $tmp
    perl -pi -e 's/> \n/>/g' $tmp && perl -pi -e 's/>\n/>/g' $tmp
    perl -pi -e 's/–/-/g' $tmp
    perl -pi -e 's/\xE2\x80\xA8//g' $tmp
    perl -pi -e 's/\[sudo\]//g' $tmp
    cat $tmp | grep -e ']\$' -e ']#' -e 'Password:' -e 'password for' | awk -F ']|:' '{print $2}' | grep -v ^$ > $new
    perl -pi -e 's/^ //g' $new
    perl -pi -e 's/^\$//g' $new
    perl -pi -e 's/^#//g' $new
    perl -pi -e 's/^ //gm' $new
    cat $new | grep -v ^$ > $tmp
    num_lines=$(wc -l $tmp | awk -F ' ' '{print $1}')
    new_num_lines=$(echo $(($num_lines-1)))
    echo $num_lines
    echo $new_num_lines
    cat $tmp | head -n $new_num_lines > $new
    rm $tmp
    mv $new $original

    echo $original

done

git add /Users/kareem/Documents/test/*txt
git commit -am "push file" &>/dev/null
git push -f origin main

echo 'Done!'