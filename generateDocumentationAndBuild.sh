#!/bin/bash

__AUTHOR__="Cris Lima Froes"
echo 'Setting up the script ...'
set -e
mkdir code_docs
cd code_docs
git clone -b gh-pages https://git@$GH_REPO_REF
cd $GH_REPO_NAME
git config --global push.default simple
git config user.name "Travis CI GIR"
git config user.email "travis@travis-ci.org"
rm -rf *
echo "" > .nojekyll
for path in ../../patrolbot_*
do
    echo "Generating rosdoc_lite code documentation for package $(basename $path) ..."
    rosdoc_lite $path -o $(basename $path) 2>&1 | tee $(basename $path).log
    if [ -d "$(basename $path)/html" ] && [ -f "$(basename $path)/html/index.html" ]; then
        echo "Uploading $(basename $path) package documentation to gh-pages branch ..."
        git add --all
        git commit -m "Deploy $(basename $path) docs to GitHub Pages Travis build: ${TRAVIS_BUILD_NUMBER}" -m "Commit: ${TRAVIS_COMMIT}"
    else
        echo '' >&2
        echo "Warning: No documentation (html) files have been found for package $(basename $path) !" >&2
        echo "Warning: Not going to push the documentation to GitHub for packge $(basename $path) !" >&2
        exit 1
    fi
done
git push --force "https://${GH_REPO_TOKEN}@${GH_REPO_REF}" > /dev/null 2>&1