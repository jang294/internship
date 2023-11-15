FROM continuumio/anaconda3:latest

WORKDIR /app
COPY . /app

# Create a conda environment and activate it
COPY environment.yml .
RUN conda env create -f environment.yml
RUN echo "source activate myenv" > ~/.bashrc
ENV PATH /opt/conda/envs/myenv/bin:$PATH
RUN conda init bash

# Expose the port that FastAPI will run on
EXPOSE 8080

# Command to run your FastAPI application
CMD ["conda", "run", "--no-capture-output", "-n", "myenv", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
