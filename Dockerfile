FROM continuumio/anaconda3:latest

WORKDIR /app
COPY . /app

# Create a conda environment and activate it
RUN conda env create -f environment.yml
RUN echo "source activate $(head -1 environment.yml | cut -d' ' -f2)" > ~/.bashrc
ENV PATH /opt/conda/envs/$(head -1 environment.yml | cut -d' ' -f2)/bin:$PATH
RUN /bin/bash -c "source ~/.bashrc"

# Make port 80 available to the world outside this container
EXPOSE 80

# Run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
