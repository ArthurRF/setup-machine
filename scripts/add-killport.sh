#!/bin/sh

echo "🧑‍💻 Configuring killport command..."

mkdir ~/scripts

cat << 'EOF' > ~/scripts/killport.sh
#!/bin/sh

if [ -z "$1" ]; then
        echo "Please, add an argument - port."
        exit 1
fi

porta=$1
pids=$(lsof -t -i :$porta)

if [ -z "$pids" ]; then
        echo "Não há processos na porta $porta."
        exit 0
fi

for pid in $pids; do
        echo "Encerrando o processo com PID $pid..."
        kill -9 $pid
done

echo "Processos encerrados na porta $porta."
EOF

chmod +x ~/scripts/killport.sh

echo "
alias killport="$HOME/scripts/killport.sh"
" >> ~/.bashrc
echo "
alias killport="$HOME/scripts/killport.sh"
" >> ~/.zshrc

echo ""
echo "╔════════════════════════════════╗"
echo "║ ✅ Killport script configured! ║"
echo "╚════════════════════════════════╝"
echo ""