#! /bin/bash

show_question() {
  echo -e "\033[1;34m$@\033[0m"
}

show_dir() {
  echo -e "\033[1;32m$@\033[0m"
}

show_error() {
  echo -e "\033[1;31m$@\033[0m"
}

end() {
  echo -e "\nExiting...\n"
  exit 0
}

continue() {
  show_question "\nDo you want to continue? (Y)es, (N)o : \n"
  read INPUT
  case $INPUT in
    [Yy]* ) ;;
    [Nn]* ) end;;
    * ) show_error "\nSorry, try again."; continue;;
  esac
}

replace() {
  show_question "\nFound an existing installation. Replace it? (Y)es, (N)o :\n" 
  read INPUT
  case $INPUT in
    [Yy]* ) rm -rf "$@/Oranchelo*" 2>/dev/null;;
    [Nn]* ) ;;
    * ) show_error "\tSorry, try again."; replace $@;;
  esac
}

install() {

  if [ "$UID" -eq "$ROOT_UID" ]; then

    echo -e "\nOranchelo Icon Theme will be installed in:\n"
    show_dir "\t$ROOT_DIR"
    echo -e "\nIt will be available to all users."
    continue

    if [[ -d $ROOT_DIR/Oranchelo && -d $ROOT_DIR/Oranchelo-Green ]]; then
      replace $ROOT_DIR
    fi

    echo -e "\nInstalling Oranchelo..."
    cp -rf Oranchelo* $ROOT_DIR
    chmod -R 755 $ROOT_DIR/Oranchelo $ROOT_DIR/Oranchelo-Green
    echo "Installation complete!"
    echo "Do not forget you have to set icon theme."
    end

  elif [ "$UID" -ne "$ROOT_UID" ]; then

    echo -e "\nOranchelo Icon Theme will be installed in:\n"
    show_dir "\t$USER_DIR"
    echo -e "\nTo make them available to all users, run this script as root."
    continue

    if [[ -d $USER_DIR/Oranchelo && -d $USER_DIR/Oranchelo-Green ]]; then
      replace $USER_DIR
    fi
    
    echo -e "\nInstalling Oranchelo..."
    if [ -d $USER_DIR ]; then
      cp -rf Oranchelo* $USER_DIR
    else
      mkdir -p $USER_DIR
      cp -rf Orachelo* $USER_DIR
    fi
    echo "Installation complete!"
    echo "Do not forget you have to set icon theme."
    end
  fi
}

remove() {

  if [ "$UID" -eq "$ROOT_UID" ]; then

    if [[ -d $ROOT_DIR/Oranchelo && -d $ROOT_DIR/Oranchelo-Green ]]; then
      echo -e "\nOranchelo Icon Theme installed in:\n"
      show_dir "\t$ROOT_DIR"
      echo -e "\nIt will remove for all users."
      continue
    else
      show_error "\nOranchelo Icon Theme is not installed in:\n"
      show_dir "\t$ROOT_DIR\n"
      end
    fi

    echo -e "\nRemoving Oranchelo..."
    rm -rf $ROOT_DIR/Oranchelo*
    echo "Removing complete!"
    echo "I hope to see you soon."
    end

  elif [ "$UID" -ne "$ROOT_UID" ]; then

    if [[ -d $USER_DIR/Oranchelo && -d $USER_DIR/Oranchelo-Green ]]; then
      echo -e "\nOranchelo Icon Theme installed in:\n"
      show_dir "\t$USER_DIR"
      echo -e "\nIt will remove only for current user."
      continue
    else
      show_error "\nOranchelo Icon Theme is not installed in:\n"
      show_dir "\t$USER_DIR\n"
      end
    fi

    echo -e "\nRemoving Oranchelo..."
    rm -rf $USER_DIR/Oranchelo*
    echo "Removing complete!"
    echo "I hope to see you soon."
    end
  fi  

}

main() {
  show_question "What you want to do: (I)nstall, (R)emove : \n"
  read INPUT
  case $INPUT in
    [Ii]* ) install;;
    [Rr]* ) remove;;
    * ) show_error "\nSorry, try again."; main;;
  esac
}


ROOT_UID=0
ROOT_DIR="/usr/share/icons"
USER_DIR="$HOME/.local/share/icons"

echo -e "\e[1m\n+---------------------------------------------+"
echo -e "|    Oranchelo Icon Theme Installer Script    |"
echo -e "+---------------------------------------------+\n\e[0m"

main