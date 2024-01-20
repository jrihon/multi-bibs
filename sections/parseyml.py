import yaml


with open("first.yml", "r") as stream:
    try:
        ymlfile = yaml.safe_load(stream)
    except yaml.YAMLError as exc:
        print(exc)
        exit(1)

# this is the only thing we might need to output
for yml in ymlfile:
    print(yml)
