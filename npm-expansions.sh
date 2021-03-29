#!/usr/bin/env bash

npm-expansions() {
  case $1 in
  --help | -h)
    echo 'npm-expansions'
    echo
    echo 'USAGE'
    echo '  npm-expansions [all [--comments]|--help|-h|--name|-n|--version|-v] [-- ...]'
    echo
    echo '  npm-expansions                         Default: random expansion'
    echo '  npm-expansions -- ...                  Sorts the result with ... first'
    echo '  npm-expansions all [--comments]        Prints all of the expansions (--comments keeps comments)'
    echo '  npm-expansions --help, -h              Print this help output'
    echo '  npm-expansions --name, -n              Print the name'
    echo '  npm-expansions --version, -v           Tell the version'
    echo
    echo 'EXAMPLES'
    echo
    echo '  npm-expansions'
    echo '  npm-expansions all'
    echo '  npm-expansions --help'
    echo '  npm-expansions -v'
    echo '  npm-expansions --comments'
    echo '  npm-expansions all --comments -- '
    echo '  npm-expansions -- sed "s/N/a/g"'
    return
    ;;

  --version | -v)
    echo '1.0'
    return
    ;;

  --name | -n)
    echo 'npm-expansions'
    return
    ;;

  esac

  ALL=false
  if [ "$1" = "all" ]; then
    shift
    ALL=true
  fi

  NO_COMMENTS=true
  FOUND_SORT=false
  for arg in "$@"; do
    case $arg in
    --comments)
      shift
      NO_COMMENTS=false
      ;;

    --)
      shift
      FOUND_SORT=true
      break 2
      ;;

    *)
      echo "Unexpected argument: \"$arg\""
      return 1
      ;;

    esac
  done

  if [ "$ALL" = true ]; then
    if [ "$NO_COMMENTS" = true ]; then
      if [ "$FOUND_SORT" = true ]; then
        curl -s -o- https://unpkg.com/npm-expansions@2.2.5/expansions.txt | sed '/^#/d' | $@
      else
        curl -s -o- https://unpkg.com/npm-expansions@2.2.5/expansions.txt | sed '/^#/d'
      fi
    else
      if [ "$FOUND_SORT" = true ]; then
        curl -s -o- https://unpkg.com/npm-expansions@2.2.5/expansions.txt | $@
      else
        curl -s -o- https://unpkg.com/npm-expansions@2.2.5/expansions.txt
      fi
    fi
  else
    if [ "$NO_COMMENTS" = true ]; then
      if [ "$FOUND_SORT" = true ]; then
        curl -s -o- https://unpkg.com/npm-expansions@2.2.5/expansions.txt | sed '/^#/d' | $@ | sort -R | head -n 1
      else
        curl -s -o- https://unpkg.com/npm-expansions@2.2.5/expansions.txt | sed '/^#/d' | sort -R | head -n 1
      fi
    else
      if [ "$FOUND_SORT" = true ]; then
        curl -s -o- https://unpkg.com/npm-expansions@2.2.5/expansions.txt | $@ | sort -R | head -n 1
      else
        curl -s -o- https://unpkg.com/npm-expansions@2.2.5/expansions.txt | sort -R | head -n 1
      fi
    fi
  fi
}
