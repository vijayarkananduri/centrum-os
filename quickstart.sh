#!/bin/bash

# Centrum OS Quick Start Script
# Runs common tasks in sequence

echo "Centrum OS Quick Start"
echo "======================"
echo ""

# Configure user
echo "Step 1: Configure your name"
read -p "Enter your name: " USER_NAME
centrum config USER_NAME "$USER_NAME"
echo ""

# Show greeting
echo "Step 2: View your greeting"
centrum greet
echo ""

# Add sample tasks
echo "Step 3: Add sample tasks to agenda"
centrum agenda add "Review project roadmap"
centrum agenda add "Update documentation"
centrum agenda add "Test new features"
echo ""

# Show agenda
echo "Step 4: View your agenda"
centrum agenda list
echo ""

# Show status
echo "Step 5: View system status"
centrum status
echo ""

echo "Quick start complete!"
echo "Try:"
echo "  centrum work [project]   - Open a project"
echo "  centrum focus 45         - Start a 45-min focus session"
echo "  centrum agenda           - Manage tasks"
echo "  centrum help             - See all commands"
