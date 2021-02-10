#!/bin/bash

declare -a versions=(
        "latest"
        "8.0"
        "7.4"
        "7.3"
        "7.2"
    )

basePath="generated"
buildScriptPath="build.sh"

# remove existing build script
if [ -f "$buildScriptPath" ]; then
    rm "$buildScriptPath"
fi

# add header and make executable
echo "#!/bin/sh" > "$buildScriptPath"
chmod +x "$buildScriptPath"

for version in "${versions[@]}"
do
    versionFolder="$basePath/$version"
    dockerFilePath="$versionFolder/Dockerfile"

    # make versionFolder path if it doesn't exist
    mkdir -p "$versionFolder"

    # remove existing Dockerfile if it exists
    if [ -f "$dockerFilePath" ]; then
        rm "$dockerFilePath"
    fi

    # generate new Dockerfile
    cat HEADER > "$dockerFilePath"
    cat Dockerfile.template | sed -e "s/\$VERSION/$version/g" >> "$dockerFilePath"
    cp wait-for-it.sh "$versionFolder/wait-for-it.sh"

    echo "Generated $version"
    echo "docker build -t maloneweb/docker-php-development:$version generated/$version &" >> "$buildScriptPath"
done

echo "wait" >> "$buildScriptPath"
echo "Generated build script $buildScriptPath"
