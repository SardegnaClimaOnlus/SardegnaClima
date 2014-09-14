<?php

use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity @Table(name="measures")
 */
class Measure
{
    /**
     * @Id @GeneratedValue @Column(type="integer")
     * @var string
     */
    protected $id;


    /** 
     * @Column(type="datetime", name="date") 
     */
    protected $date;


    /** 
     * @Column(type="float", name="temp", precision=4, scale=1) 
     */
    protected $temp;

    /** 
     * @Column(type="float", name="tempmax", precision=4, scale=1) 
     */
    protected $tempmax;

    /** 
     * @Column(type="float", name="tempmin", precision=4, scale=1) 
     */
    protected $tempmin;

    /** 
     * @Column(type="float", name="hum", precision=3, scale=0) 
     */
    protected $hum;

    /** 
     * @Column(type="float", name="dp", precision=4, scale=1) 
     */
    protected $dp;

    /** 
     * @Column(type="float", name="wchill", precision=4, scale=1) 
     */
    protected $wchill;

    /** 
     * @Column(type="float", name="hindex", precision=4, scale=1) 
     */
    protected $hindex;

    /** 
     * @Column(type="float", name="wspeed", precision=5, scale=1) 
     */
    protected $wspeed;

    /** 
     * @Column(type="string", columnDefinition="CHAR(3)" , name="dir") 
     */
    protected $dir;


    /** 
     * @Column(type="float", name="bar", precision=6, scale=1) 
     */
    protected $bar;

    /** 
     * @Column(type="float", name="rain", precision=7, scale=2) 
     */
    protected $rain;

    /** 
     * @Column(type="float", name="rr", precision=7, scale=2) 
     */
    protected $rr;

    /** 
     * @Column(type="float", name="rainmt", precision=7, scale=2) 
     */
    protected $rainmt;

    /** 
     * @Column(type="float", name="rainyr", precision=7, scale=2) 
     */
    protected $rainyr;

    /** 
     * @ManyToOne(targetEntity="Station", inversedBy="measures")
     * @JoinColumn(name="station_id", referencedColumnName="id")
     */
    protected $station;



}
