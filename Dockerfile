FROM tensorflow/tensorflow:2.11.0-gpu

# Set work directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Python 3.11.3 (optional if you require an exact version and it's different from the base image)
# RUN apt-get update && apt-get install -y python3.11

# Install necessary libraries

RUN apt update && apt-get install -y ffmpeg 

RUN apt install libportaudio2 -y

RUN pip install ipyfilechooser==0.6.0 \
    tensorflow-probability==0.15.0 \
    protobuf==3.20.0 \
    jupyter


RUN pip install -U ddsp[data_preparation] 

# Expose port for the web GUI
EXPOSE 8000

# execute the command jupyter notebook --ip='*' --NotebookApp.token='' --NotebookApp.password='' --port 8000 --allow-root
CMD ["jupyter", "notebook", "--ip='*'", "--NotebookApp.token=''", "--NotebookApp.password=''", "--port", "8000", "--allow-root"]