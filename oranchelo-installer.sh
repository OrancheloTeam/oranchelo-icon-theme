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

  # PREVIEW

  # Show destination directory
  echo -e "\nOranchelo Icon Theme will be installed in:\n"
  show_dir "\t$DEST_DIR"
  if [ "$UID" -eq "$ROOT_UID" ]; then
    echo -e "\nIt will be available to all users."
  else
    echo -e "\nTo make them available to all users, run this script as root."
  fi

  continue

  # INSTALL

  # Check destination directory
  if [ ! -d $DEST_DIR ]; then
    mkdir -p $DEST_DIR
  elif [ -d $DEST_DIR/Oranchelo ]; then
    replace $DEST_DIR
  fi

  echo -e "\nInstalling Oranchelo..."

  # Copying files
  cp -rf Oranchelo* $DEST_DIR
  chmod -R 755 $DEST_DIR/Oranchelo*

  echo "Installation complete!"
  echo "Do not forget you have to set icon theme."
}

remove() {

  # PREVIEW

  # Show installation directory
  if [ -d $DEST_DIR/Oranchelo ]; then
    echo -e "\nOranchelo Icon Theme installed in:\n"
    show_dir "\t$DEST_DIR"
    if [ "$UID" -eq "$ROOT_UID" ]; then
      echo -e "\nIt will remove for all users."
    else
      echo -e "\nIt will remove only for current user."
    fi

    continue

  else
    show_error "\nOranchelo Icon Theme is not installed in:\n"
    show_dir "\t$DEST_DIR\n"
    end
  fi

  # REMOVE

  echo -e "\nRemoving Oranchelo..."

  # Removing files
  rm -rf $DEST_DIR/Oranchelo*

  echo "Removing complete!"
  echo "I hope to see you soon."
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
DEST_DIR=

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/icons"
else
  DEST_DIR="$HOME/.local/share/icons"
fi

echo -e "\e[1m\n+---------------------------------------------+"
echo -e "|    Oranchelo Icon Theme Installer Script    |"
echo -e "+---------------------------------------------+\n\e[0m"

main
