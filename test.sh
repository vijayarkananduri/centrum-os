# Centrum OS Testing Suite
# Validates all modules and functionality

#!/bin/bash

set -e

echo "Centrum OS Test Suite v0.1"
echo "==========================="necho ""

TESTS_PASSED=0
TESTS_FAILED=0

# Test 1: Check installation
echo "[TEST 1] Installation check..."
if command -v centrum &> /dev/null; then
    echo "  ✓ Centrum command found"
    ((TESTS_PASSED++))
else
    echo "  ✗ Centrum command not found"
    ((TESTS_FAILED++))
fi

# Test 2: Memory system
echo "[TEST 2] Memory system..."
if [[ -d "$HOME/.centrum/memory" ]]; then
    echo "  ✓ Memory directory exists"
    ((TESTS_PASSED++))
else
    echo "  ✗ Memory directory not found"
    ((TESTS_FAILED++))
fi

# Test 3: Configuration
echo "[TEST 3] Configuration..."
if [[ -f "$HOME/.centrum/config/centrum.conf" ]]; then
    echo "  ✓ Configuration file found"
    ((TESTS_PASSED++))
else
    echo "  ✗ Configuration file not found"
    ((TESTS_FAILED++))
fi

# Test 4: Themes
echo "[TEST 4] Themes..."
if [[ -d "$HOME/.centrum/themes" ]] && ls "$HOME/.centrum/themes"/*.theme &> /dev/null; then
    echo "  ✓ Theme files found"
    ((TESTS_PASSED++))
else
    echo "  ✗ Theme files not found"
    ((TESTS_FAILED++))
fi

# Test 5: Test greet module
echo "[TEST 5] Greet module..."
if timeout 5 centrum greet &> /dev/null; then
    echo "  ✓ Greet module works"
    ((TESTS_PASSED++))
else
    echo "  ✗ Greet module failed"
    ((TESTS_FAILED++))
fi

# Test 6: Test help
echo "[TEST 6] Help system..."
if centrum help | grep -q "USAGE"; then
    echo "  ✓ Help system works"
    ((TESTS_PASSED++))
else
    echo "  ✗ Help system failed"
    ((TESTS_FAILED++))
fi

# Test 7: Test agenda
echo "[TEST 7] Agenda module..."
if centrum agenda list &> /dev/null; then
    echo "  ✓ Agenda module works"
    ((TESTS_PASSED++))
else
    echo "  ✗ Agenda module failed"
    ((TESTS_FAILED++))
fi

# Test 8: Test status
echo "[TEST 8] Status module..."
if timeout 5 centrum status &> /dev/null; then
    echo "  ✓ Status module works"
    ((TESTS_PASSED++))
else
    echo "  ✗ Status module failed"
    ((TESTS_FAILED++))
fi

echo ""
echo "=============================="
echo "Tests passed: $TESTS_PASSED"
echo "Tests failed: $TESTS_FAILED"
echo "=============================="
echo ""

if [[ $TESTS_FAILED -eq 0 ]]; then
    echo "All tests passed!"
    exit 0
else
    echo "Some tests failed."
    exit 1
fi
