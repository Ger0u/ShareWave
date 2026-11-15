#!/bin/bash
set -e

PROFILE="$1"
if [ -z "$PROFILE" ]; then
    echo "Ошибка: укажите имя профиля"
    exit 1
fi

if [ ! -f "$HOME/.conan2/profiles/default" ]; then
    echo "=== Создаём профиль default ==="
    conan profile detect
fi

if [ ! -f "$HOME/.conan2/settings_user.yml" ]; then
    echo "=== Применяем settings_user.yml ==="
    conan config install conan/settings_user.yml
fi

case "$PROFILE" in
    clang-debug)         OUTPUT="build/clang" ;;
    clang-debug-asan)    OUTPUT="build/clang/ASan" ;;
    clang-debug-tsan)    OUTPUT="build/clang/TSan" ;;
    clang-release)       OUTPUT="build/clang" ;;
    clang-release-asan)  OUTPUT="build/clang/ASan" ;;
    gcc-release)         OUTPUT="build/gcc" ;;
    *) echo "Неизвестный профиль: $PROFILE"; exit 1 ;;
esac

conan install . --build=missing --output-folder="$OUTPUT" --profile="profiles/$PROFILE" -o "boost/*:without_cobalt=True"
cmake --preset "$PROFILE"
