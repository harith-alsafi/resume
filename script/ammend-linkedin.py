import json
import os

INPUT_FILE = os.path.join("data", "all-exp.json")


def process_description(obj):
    """
    Recursively traverse a nested dict/list and process 'description' fields:
    - Convert string with '-' and '\n' into a list of items
    - Keep existing lists as-is
    """
    if isinstance(obj, dict):
        for key, value in obj.items():
            if key == "description":
                if isinstance(value, str):
                    # Split by '\n' and remove leading '- ' and extra spaces
                    items = [line.lstrip('- ').strip() for line in value.split('\n') if line.strip()]
                    obj[key] = items
            else:
                process_description(value)
    elif isinstance(obj, list):
        for item in obj:
            process_description(item)


def main():
    # Read JSON file
    with open(INPUT_FILE, "r", encoding="utf-8") as f:
        data = json.load(f)

    # Process descriptions
    process_description(data)

    # Write back to JSON file
    with open(INPUT_FILE, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=4)

    print(f"Processed descriptions in {INPUT_FILE}")


if __name__ == "__main__":
    main()
