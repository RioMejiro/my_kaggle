ARG LANG
ARG LANGUAGE
ARG LC_ALL

# 現行ではGPUを使用しないが、諸々更新が続いているのはこちらのシリーズなので採用。
FROM gcr.io/kaggle-gpu-images/python:v142

#言語と地域の設定
ENV lang=${LANG} language=${LANGUAGE} lc_all=${LC_ALL}

RUN mkdir -p /kaggle/input
RUN mkdir -p /kaggle/output
RUN mkdir -p /kaggle/scripts
WORKDIR /kaggle

#ライブラリのインストール
#各々のGPUに対応するpytorchをインストールhttps://pytorch.org/get-started/previous-versions/
# RUN pip install torch==2.0.1+cu117 torchvision==0.15.2+cu117 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cu117
ADD requirements.txt /kaggle/requirements.txt
RUN pip install -r requirements.txt

#jupyter notebookの起動
ADD run.sh /opt/run.sh
RUN chmod 700 /opt/run.sh
CMD /opt/run.sh