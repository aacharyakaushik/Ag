# First Driver for Community Identity

import numpy as np

#import cProfile
import opiniongame.config as og_cfg
import scipy.io as sio
import opiniongame.IO as og_io
import opiniongame.coupling as og_coupling
import opiniongame.state as og_state
import opiniongame.adjacency as og_adj
import opiniongame.selection as og_select
import opiniongame.potentials as og_pot
import opiniongame.core as og_core
import opiniongame.stopping as og_stop
#
# process command line
#
cmdline = og_cfg.CmdLineArguments()
cmdline.printOut()
#
# load configuration
#
config = og_cfg.staticParameters()
config.readFromFile('staticParameters.cfg')

config.threshold = 0.01
config.printOut()
#
# seed PRNG: must do this before any random numbers are
# ever sampled during default generation
#
print(("SEEDING PRNG: "+str(config.startingseed)))
np.random.seed(config.startingseed)
state = og_state.WorldState.fromCmdlineArguments(cmdline, config)
#
# run
#
numberOfCommunities = 3
communityPopSize    = 4
config.popSize = numberOfCommunities * communityPopSize

# List of upper bound probability of interaction between communities
uppBound_list = np.array([0.0025])
#
# List of uniqueness Strength parameter
#
individStrength = np.arange(0.00001, 0.0039, 0.00012)
individStrength = individStrength[0:10]

config.learning_rate = 0.1
tau = 0.62
config.iterationMax = 8000
config.printOut()
#
# functions for use by the simulation engine
#
ufuncs = og_cfg.UserFunctions(og_select.PickTwoWeighted,
                              og_stop.iterationStop,
                              og_pot.createTent(tau))
                              
noInitials = np.arange(1)  # Number of different initial opinions.
noGames = np.arange(500)    # Number of different game orders. 50
# Run experiments with different adjacencies, different initials, and different order of games.
for uniqForce in individStrength:
    config.uniqstrength = uniqForce
    for upperBound in uppBound_list:
        # Generate different adjacency matrix with different prob. of interaction
        # between different communities
        state.adj = og_adj.MakeCommunityAdjDet(numberOfCommunities, communityPopSize, upperBound)
#        sio.savemat(str(upperBound) + 'adj' + '.mat', {'adj':state.adj})
        print"(upperBound, uniqForce) = (", upperBound, "," , uniqForce , ")"            
        for countInitials in noInitials:
            # for each adjacency, generate 100 different initial opinions
            # state.initialOpinions = og_opinions.initialize_opinions(config.popSize, config.ntopics)
         
            # Pick three communities with similar opinions to begin with!
            state.initialOpinions = np.zeros((config.popSize, 1))
            state.initialOpinions[0 : communityPopSize] = .1
            state.initialOpinions[communityPopSize : 2*communityPopSize] = .5
            state.initialOpinions[2*communityPopSize : 3*communityPopSize] = .9
   
            state.couplingWeights = og_coupling.weights_no_coupling(config.popSize, config.ntopics)
            all_experiments_history = {}

            print "countInitials=", countInitials + 1
            
            for gameOrders in noGames:
                print "noGames= ", gameOrders            
                #cProfile.run('og_core.run_until_convergence(config, state, ufuncs)')
                state = og_core.run_until_convergence(config, state, ufuncs)
                state.history = state.history[0:state.nextHistoryIndex,:,:]
                idx_IN_columns = [i for i in xrange(np.shape(state.history)[0]) if (i % (config.popSize)) == 0]
                state.history = state.history[idx_IN_columns,:,:]
                all_experiments_history[ 'experiment' + str(gameOrders+1)] = state.history
            og_io.saveMatrix('uB' + str(upperBound) + '_uS' + str(config.uniqstrength) + 
                             '_initCount' + str(countInitials+1) + '.mat', all_experiments_history)

