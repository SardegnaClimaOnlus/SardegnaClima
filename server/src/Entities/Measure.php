<?php


use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping AS ORM;



/**
 * @ORM\Entity
 * @Entity @Table(name="measures")
 * @entity(repositoryClass="MeasureRepository")
 */
class Measure
{

    private $logger;
    public function __construct(){
       $this->logger = Logger::getLogger('measure');

    }

    /**
     * @Id @GeneratedValue @Column(type="integer")
     * @var string
     */
    protected $id;


    /** 
     * @Column(type="datetime", name="date", nullable=true) 
     */
    protected $date;


    /** 
     * @Column(type="float", name="temp", precision=4, scale=1, nullable=true) 
     */
    protected $temp;

    /** 
     * @Column(type="float", name="tempmax", precision=4, scale=1, nullable=true) 
     */
    protected $tempmax;

    /** 
     * @Column(type="float", name="tempmin", precision=4, scale=1, nullable=true) 
     */
    protected $tempmin;

    /** 
     * @Column(type="float", name="hum", precision=3, scale=0, nullable=true) 
     */
    protected $hum;

    /** 
     * @Column(type="float", name="dp", precision=4, scale=1, nullable=true) 
     */
    protected $dp;

    /** 
     * @Column(type="float", name="wchill", precision=4, scale=1, nullable=true) 
     */
    protected $wchill;

    /** 
     * @Column(type="float", name="hindex", precision=4, scale=1, nullable=true) 
     */
    protected $hindex;

    /** 
     * @Column(type="float", name="wspeed", precision=5, scale=1, nullable=true) 
     */
    protected $wspeed;

    /** 
     * @Column(type="string", columnDefinition="CHAR(3)" , name="dir", nullable=true) 
     */
    protected $dir;


    /** 
     * @Column(type="float", name="bar", precision=6, scale=1, nullable=true) 
     */
    protected $bar;

    /** 
     * @Column(type="float", name="rain", precision=7, scale=2, nullable=true) 
     */
    protected $rain;

    /** 
     * @Column(type="float", name="rr", precision=7, scale=2, nullable=true) 
     */
    protected $rr;

    /** 
     * @Column(type="float", name="rainmt", precision=7, scale=2, nullable=true) 
     */
    protected $rainmt;

    /** 
     * @Column(type="float", name="rainyr", precision=7, scale=2, nullable=true) 
     */
    protected $rainyr;

    /** 
     * @ManyToOne(targetEntity="Station", inversedBy="measures")
     * @JoinColumn(name="station_id", referencedColumnName="id")
     */
    protected $station;




    /**
     * Get id
     *
     * @return integer 
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set date
     *
     * @param \DateTime $date
     * @return Measure
     */
    public function setDate($date)
    {
        \Logger::getLogger('measure')->trace('setDate');
        \Logger::getLogger('measure')->trace($date);
        $this->date = $date;
        return $this;
    }

    /**
     * Get date
     *
     * @return \DateTime 
     */
    public function getDate()
    {
        return $this->date;
    }

    /**
     * Set temp
     *
     * @param float $temp
     * @return Measure
     */
    public function setTemp($temp)
    {

        \Logger::getLogger('measure')->trace('setTemp');
        \Logger::getLogger('measure')->trace($temp);
        $this->temp = is_numeric($temp)? floatval($temp):null;

        return $this;
    }

    /**
     * Get temp
     *
     * @return float 
     */
    public function getTemp()
    {
        return $this->temp;
    }

    /**
     * Set tempmax
     *
     * @param float $tempmax
     * @return Measure
     */
    public function setTempmax($tempmax)
    {

        \Logger::getLogger('measure')->trace('setTempmax');
        \Logger::getLogger('measure')->trace($tempmax);
        $this->tempmax = is_numeric($tempmax)?floatval($tempmax):null;

        return $this;
    }

    /**
     * Get tempmax
     *
     * @return float 
     */
    public function getTempmax()
    {
        return $this->tempmax;
    }

    /**
     * Set tempmin
     *
     * @param float $tempmin
     * @return Measure
     */
    public function setTempmin($tempmin)
    {

        \Logger::getLogger('measure')->trace('setTempmin');
        \Logger::getLogger('measure')->trace($tempmin);
        $this->tempmin = is_numeric($tempmin)?floatval($tempmin):null;

        return $this;
    }

    /**
     * Get tempmin
     *
     * @return float 
     */
    public function getTempmin()
    {
        return $this->tempmin;
    }

    /**
     * Set hum
     *
     * @param float $hum
     * @return Measure
     */
    public function setHum($hum)
    {

        \Logger::getLogger('measure')->trace('setHum');
        \Logger::getLogger('measure')->trace($hum);
        $this->hum = is_numeric($hum)?floatval($hum):null;

        return $this;
    }

    /**
     * Get hum
     *
     * @return float 
     */
    public function getHum()
    {
        return $this->hum;
    }

    /**
     * Set dp
     *
     * @param float $dp
     * @return Measure
     */
    public function setDp($dp)
    {

        \Logger::getLogger('measure')->trace('setDp');
        \Logger::getLogger('measure')->trace($dp);
        $this->dp = is_numeric($dp)?floatval($dp):null;

        return $this;
    }

    /**
     * Get dp
     *
     * @return float 
     */
    public function getDp()
    {
        return $this->dp;
    }

    /**
     * Set wchill
     *
     * @param float $wchill
     * @return Measure
     */
    public function setWchill($wchill)
    {

        \Logger::getLogger('measure')->trace('setWChill');
        \Logger::getLogger('measure')->trace($wchill);
        $this->wchill = is_numeric($wchill)?floatval($wchill):null;

        return $this;
    }

    /**
     * Get wchill
     *
     * @return float 
     */
    public function getWchill()
    {
        return $this->wchill;
    }

    /**
     * Set hindex
     *
     * @param float $hindex
     * @return Measure
     */
    public function setHindex($hindex)
    {

        \Logger::getLogger('measure')->trace('setHindex');
        \Logger::getLogger('measure')->trace($hindex);
        $this->hindex = is_numeric($hindex)?floatval($hindex):null;

        return $this;
    }

    /**
     * Get hindex
     *
     * @return float 
     */
    public function getHindex()
    {
        return $this->hindex;
    }

    /**
     * Set wspeed
     *
     * @param float $wspeed
     * @return Measure
     */
    public function setWspeed($wspeed)
    {
        \Logger::getLogger('measure')->trace('setWspeed');
        \Logger::getLogger('measure')->trace($wspeed);
        $this->wspeed = is_numeric($wspeed)?floatval($wspeed):null;

        return $this;
    }

    /**
     * Get wspeed
     *
     * @return float 
     */
    public function getWspeed()
    {
        return $this->wspeed;
    }

    /**
     * Set dir
     *
     * @param string $dir
     * @return Measure
     */
    public function setDir($dir)
    {
        \Logger::getLogger('measure')->trace('setDir');
        \Logger::getLogger('measure')->trace($dir);
        $this->dir = ($dir)?$dir:null;

        return $this;
    }

    /**
     * Get dir
     *
     * @return string 
     */
    public function getDir()
    {
        return $this->dir;
    }

    /**
     * Set bar
     *
     * @param float $bar
     * @return Measure
     */
    public function setBar($bar)
    {
        \Logger::getLogger('measure')->trace('setBar');
        \Logger::getLogger('measure')->trace($bar);
        $this->bar = is_numeric($bar)?floatval($bar):null;

        return $this;
    }

    /**
     * Get bar
     *
     * @return float 
     */
    public function getBar()
    {
        return $this->bar;
    }

    /**
     * Set rain
     *
     * @param float $rain
     * @return Measure
     */
    public function setRain($rain)
    {
        \Logger::getLogger('measure')->trace('setRain');
        \Logger::getLogger('measure')->trace($rain);
        $this->rain = is_numeric($rain)?floatval($rain):null;

        return $this;
    }

    /**
     * Get rain
     *
     * @return float 
     */
    public function getRain()
    {
        return $this->rain;
    }

    /**
     * Set rr
     *
     * @param float $rr
     * @return Measure
     */
    public function setRr($rr)
    {
        \Logger::getLogger('measure')->trace('setRr');
        \Logger::getLogger('measure')->trace($rr);
        $this->rr = is_numeric($rr)?floatval($rr):null;

        return $this;
    }

    /**
     * Get rr
     *
     * @return float 
     */
    public function getRr()
    {
        return $this->rr;
    }

    /**
     * Set rainmt
     *
     * @param float $rainmt
     * @return Measure
     */
    public function setRainmt($rainmt)
    {
        \Logger::getLogger('measure')->trace('setRainmt');
        \Logger::getLogger('measure')->trace($rainmt);
        $this->rainmt = is_numeric($rainmt)?floatval($rainmt):null;

        return $this;
    }

    /**
     * Get rainmt
     *
     * @return float 
     */
    public function getRainmt()
    {
        return $this->rainmt;
    }

    /**
     * Set rainyr
     *
     * @param float $rainyr
     * @return Measure
     */
    public function setRainyr($rainyr)
    {
        \Logger::getLogger('measure')->trace('setRainyr');
        \Logger::getLogger('measure')->trace($rainyr);
        $this->rainyr = is_numeric($rainyr)?floatval($rainyr):null;

        return $this;
    }

    /**
     * Get rainyr
     *
     * @return float 
     */
    public function getRainyr()
    {
        return $this->rainyr;
    }

    /**
     * Set station
     *
     * @param \Station $station
     * @return Measure
     */
    public function setStation(\Station $station = null)
    {

        $this->station = $station;

        return $this;
    }

    /**
     * Get station
     *
     * @return \Station 
     */
    public function getStation()
    {
        return $this->station;
    }
}
