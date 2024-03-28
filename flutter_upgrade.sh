
# DEFINIR A VARIÁVEL DE AMBIENTE ABAIXO, COM O CAMINHO DO SDK DO FLUTTER, NO ARQUIVO .bashrc OU .zrshrc
cd $FLUTTER_SDK_PATH
# SUBSTITUIR A VERSÃO ABAIXO PELA VERSÃO DESEJADA PARA ATUALIZAÇÃO
git checkout 3.16.0
#
flutter --version
flutter pub cache repair
# flutter pub cache clean
flutter clean
flutter pub get