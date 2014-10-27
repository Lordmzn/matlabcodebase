function v = Formatter_FromNNetToThetaVec(nnet)
% I'm tired of this
% EM 15 luglio 2014
v = [nnet.net.b1 nnet.net.b2 nnet.net.w2' reshape(nnet.net.w1', 1, [])];