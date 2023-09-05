using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HideEnvironment : MonoBehaviour

{
    public GameObject Room;
    public OVRInput.Button button;
    public OVRInput.Controller controller;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (OVRInput.GetDown(button, controller))
        {
            // hide environment

            foreach (Renderer r in Room.GetComponentsInChildren<Renderer>())
                r.enabled = !r.enabled;
        }
    }
}


