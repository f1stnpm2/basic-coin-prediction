#!/bin/bash

# Đường dẫn đến file vi.txt
vi_file="/root/worker2-24h/vi.txt"

# Đường dẫn đến file JSON cần thay đổi
json_file="/root/worker2-24h/config.json"

# Đường dẫn đến file Python cần thay đổi
py_file="/root/worker2-24h/model.py"  # Thay đổi đường dẫn tới file model.py tại đây

# Kiểm tra sự tồn tại của file vi.txt
if [ ! -f "$vi_file" ]; then
  echo "File vi.txt không tồn tại."
  exit 1
fi

# Kiểm tra sự tồn tại của file JSON
if [ ! -f "$json_file" ]; then
  echo "File config.json không tồn tại."
  exit 1
fi

# Kiểm tra sự tồn tại của file Python
if [ ! -f "$py_file" ]; then
  echo "File model.py không tồn tại."
  exit 1
fi

# Đọc dòng đầu tiên từ file vi.txt và thay đổi "addressRestoreMnemonic" trong config.json
new_value_address=$(head -n 1 "$vi_file")
sed -i 's/"addressRestoreMnemonic": ".*"/"addressRestoreMnemonic": "'"$new_value_address"'"/g' "$json_file"
echo "Đã thay đổi giá trị 'addressRestoreMnemonic' trong file config.json."

# Đọc dòng thứ hai từ file vi.txt và thay đổi "fluctuation_range = 0.001 * predicted_price" trong model.py
new_value_fluctuation=$(sed -n '2p' "$vi_file")
sed -i 's/fluctuation_range = 0.001 \* predicted_price/fluctuation_range = '"$new_value_fluctuation"' \* predicted_price/g' "$py_file"
echo "Đã thay đổi giá trị của fluctuation_range trong file model.py."
