using UnityEngine;

public class ToggleCanvas : MonoBehaviour
{
    public GameObject TissueBlockCanvas;  // Assign your tissueblock Canvas GameObject in the Inspector
    public GameObject[] otherCanvases;  // Assign Other tissue blocks Canvas GameObjects in the Inspector that we don't want to display
    private bool isCanvasActive;

    void Start()
    {
        // Initially, the Canvas should be deactivated
        TissueBlockCanvas.SetActive(false);
        isCanvasActive = false;
    }

    // This method will be called when the 'Select' event triggers
    public void BlockSelection()
    {
        isCanvasActive = !isCanvasActive;
        TissueBlockCanvas.SetActive(isCanvasActive);

        // If the Main Canvas is active, hide all other canvases
        if (isCanvasActive)
        {
            foreach (GameObject canvas in otherCanvases)
            {
                canvas.SetActive(false);
            }
        }
    }
}