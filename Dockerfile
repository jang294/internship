FROM continuumio/anaconda3:latest

WORKDIR /app
COPY . /app

# Create a conda environment and activate it
COPY environment.yml .
RUN conda env create -f environment.yml
RUN echo "source activate myenv" > ~/.bashrc
ENV PATH /opt/conda/envs/myenv/bin:$PATH


# Install additional packages using conda
RUN conda install -n myenv redis=5.0.1 cement=2.8.2 semantic-version=2.8.5 pypiwin32=223 tzdata=2023.3 numpy=1.26.2 pydantic_core=2.14.1
RUN pip install --no-cache-dir -r

# Expose the port that FastAPI will run on
EXPOSE 8000

# Command to run your FastAPI application
CMD ["conda", "run", "--no-capture-output", "-n", "myenv", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
