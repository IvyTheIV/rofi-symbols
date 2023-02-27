#!/usr/bin/env bash

recently_used_file=$HOME/.config/rofi/rofi-symbols/recent
symbols_folder=$HOME/.config/rofi/rofi-symbols/symbols

rofi_copy=false

main() {
    prompt="symbols"

    if $rofi_copy
    then
        prompt="$prompt (copy)"
    fi
    echo -en "\0prompt\x1f$prompt\n"

    recent=""
    if [[ -f "$recently_used_file" ]]
    then
        recent=$(cat "$recently_used_file")
    fi

    if [[ "$*" ]]
    then
        output=$(echo "$*" | sed 's/ .*$//')

        if $rofi_copy
        then
            coproc { sleep 0.1; \
                printf "%s""$output" | xclip -selection clipboard; }
        else
            coproc { sleep 0.3; \
                xdotool type "$output" > /dev/null; }
        fi
        
        first=$(echo "$recent" | head -n 1 | sed 's/ .*$//')

        if [[ "$first" != "$output" ]]
        then
            new_recent=""
            if [[ "$recent" == *"$output"* ]]
            then
                new_recent=$(printf "%s\n" "$*"; echo "$recent")
                new_recent=$(echo "$new_recent" | awk '! a[$0]++')
            else
                new_recent=$(printf "%s\n" "$*"; echo "$recent")
            fi

            echo "$new_recent" | head -n 5 > "$recently_used_file"
        fi

        exit 0
    fi

    display_recent=""
    if [[ "$recent" ]]
    then
        display_recent=$(printf "%s\n" "$recent" | head -n 5; \
            printf "%s" "\n ""\0""nonselectable\x1ftrue\n")
    fi

    display_symbols=$(cat "$symbols_folder"/*.symbols | grep "^[^#]")

    if [[ "$display_symbols" ]]
    then
        echo -en "$display_recent""$display_symbols"\
            | awk '! a[$0]++'
    else
        echo -en "\0message\x1fno symbols found in ""$symbols_folder"
    fi
}

if [[ "$1" == "copy" ]]
then
    rofi_copy=true
    main "${@:2}"
else
    rofi_copy=false
    main "$@"
fi
