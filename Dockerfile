FROM nvidia/caffe

RUN apt-get update && apt-get install -y \
        git 

CMD ["git", "clone", "https://github.com/amsword/setup.git"]
