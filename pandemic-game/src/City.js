import './App.css';

export default function City(props) {

    const cubes = Object.entries(props.city.cubes).map((cube) => {
        if(cube[1] > 0) {
            return <div className={`cube ${cube[0]}`}>{cube[1]}</div>
        }
    });

    let researchStation;
    if (props.city.has_research_station) {
        researchStation = <div className="researchStation"></div>
    }

    return (
        <div id={props.city.name} className={`city ${props.city.color}`}>
            {cubes}
            {researchStation}
            <div className="cityName">{props.city.visible_name}</div>
        </div>)
}