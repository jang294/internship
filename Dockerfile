FROM continuumio/anaconda3:latest

WORKDIR /app
COPY . /app

# Create a conda environment and activate it
RUN conda install --file requirements.txt

# Activate the Conda environment
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

# Expose the port that FastAPI will run on
EXPOSE 8080

# Command to run your FastAPI application
CMD ["conda", "run", "--no-capture-output", "-n", "myenv", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
