using UnityEngine;

public class ToggleCPCanvas : MonoBehaviour
{
    public GameObject ClippingPlanesCanvas;  // Assign your Clipping Planes Canvas GameObject in the Inspector
    public GameObject[] otherClippingPlanesCanvases;  // Assign OtherClipping Planes Canvas GameObjects in the Inspector that we don't want to display
    private bool isCanvasActive;

    void Start()
    {
        // Initially, the Canvas should be deactivated
        ClippingPlanesCanvas.SetActive(false);
        isCanvasActive = false;
    }

    // This method will be called when the 'Select' event triggers
    public void ToggleVisibility()
    {
        isCanvasActive = !isCanvasActive;
        ClippingPlanesCanvas.SetActive(isCanvasActive);

        // If the Main Canvas is active, hide all other canvases
        if (isCanvasActive)
        {
            foreach (GameObject canvas in otherClippingPlanesCanvases)
            {
                canvas.SetActive(false);
            }
        }
    }
}