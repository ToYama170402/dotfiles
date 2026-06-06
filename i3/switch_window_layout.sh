#!/bin/bash

# スクリプトが格納されているディレクトリのパス
scripts_dir="$HOME/.screenlayout"

# i3statusに表示するための情報を書き出すファイル
status_file="/tmp/current_window_layout"

scripts=()
if [ -d "$scripts_dir" ]; then
    while IFS= read -r -d '' file; do
        scripts+=("$file")
    done < <(find "$scripts_dir" -maxdepth 1 -type f -executable -print0 | sort -z)
fi

if [ ${#scripts[@]} -eq 0 ]; then
    # スクリプトがない場合は、ステータス表示も空にする
    echo "" > "$status_file"
    exit 0
fi

state_file="$HOME/.config/i3/script_cycle_state"

if [ ! -f "$state_file" ]; then
    echo "1" > "$state_file"
fi

current_index=$(cat "$state_file")

if [ "$current_index" -gt "${#scripts[@]}" ]; then
    current_index=1
fi

script_to_run="${scripts[$((current_index - 1))]}"

# 実行するスクリプトのファイル名だけを取得
script_basename=$(basename "$script_to_run")

notify-send  "Current display layout" "$script_basename"

# スクリプトを実行
"$script_to_run"

next_index=$((current_index % ${#scripts[@]} + 1))
echo "$next_index" > "$state_file"
