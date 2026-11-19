#!/bin/bash
set -e

cd "$(dirname "$0")/.."

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
    clang-debug)         OUTPUT="build/clang/Debug" ;;
    clang-debug-asan)    OUTPUT="build/clang/ASan/Debug" ;;
    clang-debug-tsan)    OUTPUT="build/clang/TSan/Debug" ;;
    clang-release)       OUTPUT="build/clang/Release" ;;
    clang-release-asan)  OUTPUT="build/clang/ASan/Release" ;;
    gcc-release)         OUTPUT="build/gcc/Release" ;;
    *) echo "Неизвестный профиль: $PROFILE"; exit 1 ;;
esac

echo "=== Conan install для профиля $PROFILE ==="

CONAN_OPTS=(-o "boost/*:without_cobalt=True")

if [ "$PROFILE" = "clang-debug-tsan" ]; then
    CONAN_OPTS+=(-o "boost/*:extra_b2_flags=thread-sanitizer=on")
fi

conan remove "gtest/*"

conan install . --build=missing --output-folder="$OUTPUT/.." --profile="profiles/$PROFILE" "${CONAN_OPTS[@]}"

echo "=== CMake preset $PROFILE ==="
cmake --preset "$PROFILE"

echo "=== CMake build $PROFILE ==="
cmake --build --preset "$PROFILE"

echo "=== Активация окружения Conan для $PROFILE ==="
source "$OUTPUT/generators/conanrun.sh"

echo "=== Запуск тестов для $PROFILE ==="
ctest --test-dir "$OUTPUT" --output-on-failure --output-junit "$PWD/build/test-results.xml"

echo "=== Отчёт о тестах: $PWD/build/test-results.xml ==="
