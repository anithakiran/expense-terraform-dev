#!/bin/bash
dnf install ansible -y 
cd /tmp
git clone https://github.com/anithakiran/expense-ansible-role.git
cd expense-ansible-roles
ansible-playbook main.yaml -e component=backend -e login_password=ExpenseApp
ansible-playbook main.yaml -e component=frontend