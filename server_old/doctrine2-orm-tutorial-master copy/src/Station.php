<?php

use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity @Table(name="stations")
 */
class Station
{
    /**
     * @Id @GeneratedValue @Column(type="integer")
     * @var string
     */
    protected $id;


    /** 
     * @Column(type="datetime", name="creation_date") 
     */
    protected $creationDate;


    /** 
     * @Column(type="float", name="latitude") 
     */
    protected $latitude;

    /** 
     * @Column(type="float", name="longitude") 
     */
    protected $longitude;


    /**
     * @Column(type="string")
     */
    protected $name;

    /**
     * @Column(type="string")
     */
    protected $description;

    /**
     * @Column(type="string")
     */
    protected $data_url;

    /**
     * @Column(type="string")
     */
    protected $type;


    /**
     * @OneToMany(targetEntity="Measure", mappedBy="station")
     */
    protected $measures;

}
