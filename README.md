# NR-link-level-simulator
A collaborative platform for NR link level simulator

# NR-PDCCH 平台目前支持的功能
- CRC (LTE CRC16)；
- 插入导频 (LTE gold序列)；
- 解调 (ZF，尚待完成MMSE和LMMSE)，导频插入采用cubic-spline；
- TDL信道模型， 模拟瑞利衰落 + 多径效应 + 多普勒效应；
- QAM调制和解调；
- CP-OFDM 的发送和接收；
- 对于NR-PDCCH在时频域进行资源映射。目前支持在全频带的第一个符号进行RB选择映射；
- 加扰和交织过程未完成；

# NR-PDSCH 平台目前支持的功能 (待完成)
