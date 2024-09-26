wsl -l -v

wsl --unregister [name-wsl]

#Creando la imagen template para poder crear las demas maquinas
wsl --install -d Ubuntu-24.04
wsl --export Ubuntu-24.04 E:\win11\wsl\so-images\ubuntu24.04.tar

wsl --import [name] [destino] [origen tar]
## Un sistema operativo generico
wsl --import paul-laptop01-win11-wsl-ubuntu E:\win11\wsl\so-instances\paul-laptop01-win11-wsl-ubuntu E:\win11\wsl\so-images\ubuntu24.04.tar

wsl --import paul-laptop01-win11-wsl-w001-app E:\win11\wsl\so-instances\paul-laptop01-win11-wsl-w001-app E:\win11\wsl\so-images\ubuntu24.04.tar
wsl --import paul-laptop01-win11-wsl-w002-app E:\win11\wsl\so-instances\paul-laptop01-win11-wsl-w002-app E:\win11\wsl\so-images\ubuntu24.04.tar
wsl --import paul-laptop01-win11-wsl-study-app E:\win11\wsl\so-instances\paul-laptop01-win11-wsl-study-app E:\win11\wsl\so-images\ubuntu24.04.tar
wsl --import paul-laptop01-win11-wsl-sandbox-app E:\win11\wsl\so-instances\paul-laptop01-win11-wsl-sandbox-app E:\win11\wsl\so-images\ubuntu24.04.tar

wsl --import paul-laptop01-win11-wsl-w001-app D:\win11\wsl\so-instances\paul-laptop01-win11-wsl-w001-app-temp E:\win11\wsl\so-images\ubuntu24.04.tar

wsl -d [name-wsl] -u [username]

wsl --unregister paul-laptop01-win11-wsl-ubuntu
wsl --unregister paul-laptop01-win11-wsl-w001-app
wsl --unregister paul-laptop01-win11-wsl-w002-app
wsl --unregister paul-laptop01-win11-wsl-study-app
wsl --unregister paul-laptop01-win11-wsl-sandbox-app

wsl -d paul-laptop01-win11-wsl-ubuntu -u paul
wsl -d paul-laptop01-win11-wsl-w001-app -u paul
wsl -d paul-laptop01-win11-wsl-w002-app -u paul
wsl -d paul-laptop01-win11-wsl-study-app -u paul
wsl -d paul-laptop01-win11-wsl-sandbox-app -u paul

wsl -d paul-laptop01-win11-wsl-w001-app-temp -u paul

wsl --terminate paul-laptop01-win11-wsl-w001-app
wsl --terminate paul-laptop01-win11-wsl-w002-app
wsl --terminate paul-laptop01-win11-wsl-study-app
wsl --terminate paul-laptop01-win11-wsl-sandbox-app

wsl --unregister paul-laptop01-win11-wsl-w001-app
wsl --import paul-laptop01-win11-wsl-w001-app E:\win11\wsl\so-instances\paul-laptop01-win11-wsl-w001-app E:\win11\wsl\so-images\ubuntu24.04.tar
wsl -d paul-laptop01-win11-wsl-w001-app -u paul

wsl --terminate paul-laptop01-win11-wsl-w001-app
wsl -d paul-laptop01-win11-wsl-w001-app -u paul
