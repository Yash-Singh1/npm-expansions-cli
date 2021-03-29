if [ -n "$1" ]; then
  VERSION="$1"
else
  VERSION="1.0"
fi

curl -s -o- https://raw.githubusercontent.com/Yash-Singh1/npm-expansions-cli/$VERSION/npm-expansions.sh > ~/npm-expansions.sh
echo 'source ~/npm-expansions.sh' > '.bashrc'
source ~/npm-expansions.sh
