yes 'y' | sudo apt-get remove unscd; yes 'y' | sudo apt-get install python-pip; pip install sox wget; yes 'y' | sudo apt-get install sox libsox-fmt-mp3

cd ../dataset
if [ -d "LibriSpeech_dataset" ]
then
	echo "\n\nLibrispeech folder found, skipping download.\n\n"
	sleep 3
else
	echo "\n\nDownloading all, (est. 120+ min)...\n\n"
	sleep 3
	sh download_dataset.sh all
fi
cd ../inference	

if [ "${1}" = "cuda" ]
then
	VARIANT="cuda_"
	yes 'y' | sudo add-apt-repository ppa:graphics-drivers/ppa
	yes 'y' | sudo apt-get update
	yes 'y' | sudo apt-get install nvidia
	yes 'y' | sudo apt-get install cuda-drivers
	yes 'y' | sudo apt-get install htop
else
	VARIANT=""
fi

cd ../docker
yes 'y' | sh install_${VARIANT}docker.sh

yes 'y' | sh build_${VARIANT}docker.sh

cd ../inference
echo "Ready to run: sh ../docker/run_${VARIANT}dev.sh"

