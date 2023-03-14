import React, { useContext } from "react";
import { Network } from "../redux/networks";

export const NetworkContext = React.createContext<Network>(null!);

export const useNetworkContext = () => useContext(NetworkContext);
