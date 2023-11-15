FROM continuumio/anaconda3:latest

WORKDIR /app
COPY . /app

# Create a conda environment and activate it
COPY environment.yml .
RUN conda env create -f environment.yml

# Activate the Conda environment
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

# Copy the entire project into the container
COPY . .

# Expose the port that FastAPI will run on
EXPOSE 8000

# Command to run your FastAPI application
CMD ["conda", "run", "--no-capture-output", "-n", "myenv", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
