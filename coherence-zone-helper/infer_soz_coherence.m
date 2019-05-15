function model = infer_soz_coherence( model, pc)
% INFER_SOZ_COHERENCE computes zone coherence in left SOZ, right SOZ and
% left to right SOZ

[LN,RN] = find_subnetwork_coords(pc);
fprintf('...computing left SOZ coherence \n')
model.left = compute_soz_coherence(model,LN);

fprintf('...computing right SOZ coherence \n')
model.right = compute_soz_coherence(model,RN);

fprintf('...computing left to right SOZ coherence \n')
nodes.source = LN;
nodes.target = RN;
model.across = compute_soz_coherence(model,nodes);

fprintf('...computing dom pre-post SOZ coherence \n')
[PreN,PostN,PrUp,PoUp] = find_subnetwork_prepost(pc);
nodes.source = PreN;
nodes.target = PostN;
model.prepost = compute_soz_coherence(model,nodes);

fprintf('...computing dom pre-post in upper SOZ coherence \n')
nodes.source = PrUp;
nodes.target = PoUp;
model.prepost_upper = compute_soz_coherence(model,nodes);


fprintf('...computing dom pre & post SOZ coherence \n')
model.prepost_all = compute_soz_coherence(model,[PreN; PostN]);

fprintf('...computing dom pre & post upper SOZ coherence \n')
model.prepost_all_upper = compute_soz_coherence(model,[PrUp; PoUp]);

% ----- Find other pre to post coherence -----------------------------
pc_temp =pc;
hand = pc.hand;
if strcmp(hand,'right')
   pc_temp.hand = 'left';
end

if strcmp(hand,'left')
    pc_temp.hand = 'right';
end

fprintf('...computing non dom pre-post SOZ coherence \n')
[PreN,PostN,PrUp,PoUp] = find_subnetwork_prepost(pc_temp);
nodes.source = PreN;
nodes.target = PostN;
model.prepost_nondom = compute_soz_coherence(model,nodes);

fprintf('...computing non dom pre-post in upper SOZ coherence \n')
nodes.source = PrUp;
nodes.target = PoUp;
model.prepost_upper_nondom = compute_soz_coherence(model,nodes);


fprintf('...computing non dom pre & post SOZ coherence \n')
model.prepost_all_nondom = compute_soz_coherence(model,[PreN; PostN]);

fprintf('...computing non dom pre & post upper SOZ coherence \n')
model.prepost_all_upper_nondom = compute_soz_coherence(model,[PrUp; PoUp]);




[ LNstl,~ ] = find_subnetwork_str( pc,'superiortemporal');
fprintf('...computing SOZ to superior temporal lobe coherence left \n')
nodes.source = LN;
nodes.target = LNstl;
model.phoneme_left =compute_soz_coherence(model,nodes);

fprintf('...computing within left superior temporal lobe coherence \n')
model.left_stl =compute_soz_coherence(model,LNstl);


% %%% ----- Normalize by other brain region left and right ------------------
% 
% [ LNf,RNf] = find_subnetwork_str( pc,'superiorfrontal');
% fprintf('...computing left superior frontal lobe coherence \n');
% if length(LN) < length(LNf)
%     i = randperm(length(LNf),length(LN));
%     nodes = LNf(i);
% else
%     nodes = LNf;
% end
% model.superior_frontal_left = compute_soz_coherence(model,nodes);
% model.superior_frontal_left.nodes =nodes;
% model.superior_frontal_left.LNf =LNf;
% fprintf('...computing left superior fromtal lobe coherence \n');
% if length(RN) < length(RNf)
%     i = randperm(length(RNf),length(RN));
%     nodes = RNf(i);
% else
%     nodes = RNf;
% end
% model.superior_frontal_right = compute_soz_coherence(model,nodes);
% model.superior_frontal_right.nodes =nodes;
% model.superior_frontal_right.RNf =RNf;

end




