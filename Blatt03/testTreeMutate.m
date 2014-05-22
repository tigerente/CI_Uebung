tree = treeRandGenDeep(4, 0.6, 4, 9);
treeShow(tree, ['a' 'b' 'c' 'd'], ['1' '2' '3' '4' '5' '6' '7' '8' '9']);
mutatedTree = treeMutate(tree, 0.3, 3, 0.6, 4, 9);
treeShow(mutatedTree, ['a' 'b' 'c' 'd'], ['1' '2' '3' '4' '5' '6' '7' '8' '9']);