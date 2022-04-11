import './App.css';
import {useState, useEffect} from 'react';
import City from './City';

const ADDRESS = 'http://127.0.0.1:3000';

export default function Game() {

    const [gameBoard, setGameBoard] = useState(null);
    const [players, setPlayers] = useState(2);

    const startGame = () => {
        fetch(ADDRESS + '/start?players=' + players)
            .then((response) => response.json())
            .then(newGameBoard => {
                setGameBoard(newGameBoard);
            });
    }

    const handlePlayerChange = (event) => {
        setPlayers(event.target.value);
    }

    const drawInfectionCard = () => {
        fetch(ADDRESS + '/infect?id=' + gameBoard.id)
            .then((response) => response.json())
            .then(newGameBoard => {
                setGameBoard(newGameBoard);
            });
    }

    let cities = "";
    if (gameBoard != null) {
        cities = Object.entries(gameBoard.cities).map((city) =>
            <City key={city[0]} city={city[1]}></City>);
    }

    if (gameBoard == null) {
        return (<div>
            <label>Number of players</label>
            <select value={players} onChange={handlePlayerChange}>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
            </select>
            <button onClick={startGame}>Start New Game</button>
        </div>);
    } else {
        return (
            <div id="board">
                <img className="map" src="detailed-world-map.png"></img>
                <div className="instructions"></div>
                <div className="outbreaks">
                    <h4>Outbreaks</h4>
                    <p>{gameBoard.outbreaks}</p>
                </div>
                <div className="cures">
                    <table>
                        <tr>
                            <th>Disease</th>
                            <th>Cured</th>
                            <th>Eradicated</th>
                        </tr>
                        <tr>
                            <td>Blue</td><td><input type="checkbox" disabled defaultChecked={gameBoard.cures.blue}/></td><td><input type="checkbox" disabled defaultChecked={gameBoard.eradications.blue}/></td>
                        </tr>
                        <tr>
                            <td>Yellow</td><td><input type="checkbox" disabled defaultChecked={gameBoard.cures.yellow}/></td><td><input type="checkbox" disabled defaultChecked={gameBoard.eradications.yellow}/></td>                        </tr>
                        <tr>
                            <td>Black</td><td><input type="checkbox" disabled defaultChecked={gameBoard.cures.black}/></td><td><input type="checkbox" disabled defaultChecked={gameBoard.eradications.black}/></td>
                        </tr>
                        <tr>
                            <td>Red</td><td><input type="checkbox" disabled defaultChecked={gameBoard.cures.red}/></td><td><input type="checkbox" disabled defaultChecked={gameBoard.eradications.red}/></td>
                        </tr>
                    </table>
                </div>
                <div className="inventory">
                    <table>
                        <tr>
                            <th>Inventory</th>
                        </tr>
                        <tr>
                            <td>Blue</td><td>{gameBoard.cube_inventory.blue}</td>
                        </tr>
                        <tr>
                            <td>Yellow</td><td>{gameBoard.cube_inventory.yellow}</td>
                        </tr>
                        <tr>
                            <td>Black</td><td>{gameBoard.cube_inventory.black}</td>
                        </tr>
                        <tr>
                            <td>Red</td><td>{gameBoard.cube_inventory.red}</td>
                        </tr>
                    </table>
                </div>
                <div className="infectionRate">
                    <p><b>Infection Rate:</b> {gameBoard.step.infection_rate_scale[gameBoard.step.infection_rate_index]}</p>
                </div>
                <div className="epidemic deck" onClick={gameBoard.step.current_step === "infect"? drawInfectionCard: undefined}></div>
                <div className="epidemic discard">{gameBoard.infection_deck.discard[gameBoard.infection_deck.discard.length-1]}</div>
                {cities}
            </div>);
    }


}