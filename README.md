# CUDA for deep learning training
Utilizing CUDNN / CUBLAS usage for the deep learning training using MNIST datasets.

# Dataset
```
Training Dataset: 60000 items
Testing dataset: 10000 items
```
# Model Architecture
![Untitled drawing (1)](https://github.com/Kaiwei0323/MNIST_CUDA/assets/91507316/ecb8c09a-4899-4686-9dd3-2edaa1ed472c)

# Output Result
```bash
== MNIST training with CUDNN ==
[TRAIN]
loading ./data/train-images-idx3-ubyte
loaded 60000 items..
.. model Configuration ..
CUDA: conv1
CUDA: pool
CUDA: conv2
CUDA: pool
CUDA: dense1
CUDA: relu
CUDA: dense2
CUDA: softmax
conv1: Available Algorithm Count [FWD]: 10
conv1: Available Algorithm Count [BWD-filter]: 9
conv1: Available Algorithm Count [BWD-data]: 8
.. initialized conv1 layer ..
conv2: Available Algorithm Count [FWD]: 10
conv2: Available Algorithm Count [BWD-filter]: 9
conv2: Available Algorithm Count [BWD-data]: 8
.. initialized conv2 layer ..
.. initialized dense1 layer ..
.. initialized dense2 layer ..
step:  200, loss: 0.320, accuracy: 74.080%
step:  400, loss: 0.192, accuracy: 95.232%
step:  600, loss: 0.187, accuracy: 96.277%
step:  800, loss: 0.191, accuracy: 96.369%
step: 1000, loss: 0.256, accuracy: 96.383%
step: 1200, loss: 0.251, accuracy: 96.389%
step: 1400, loss: 0.190, accuracy: 96.375%
step: 1600, loss: 0.185, accuracy: 96.367%
step: 1800, loss: 0.192, accuracy: 96.379%
step: 2000, loss: 0.273, accuracy: 96.373%
step: 2200, loss: 0.246, accuracy: 96.389%
step: 2400, loss: 0.203, accuracy: 96.383%
[INFERENCE]
loading ./data/t10k-images-idx3-ubyte
loaded 10000 items..
conv1: Available Algorithm Count [FWD]: 10
conv1: Available Algorithm Count [BWD-filter]: 9
conv1: Available Algorithm Count [BWD-data]: 8
conv2: Available Algorithm Count [FWD]: 10
conv2: Available Algorithm Count [BWD-filter]: 9
conv2: Available Algorithm Count [BWD-data]: 8
loss: 0.655, accuracy: 87.300%
Done.
```
